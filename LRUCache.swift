#!/usr/bin/swift
protocol LRUCaching {
    associatedtype K: Hashable
    associatedtype V: Equatable

    func put(_ key: K, _ value: V)
    func get(_ key: K) -> V?
}

class Node<K: Hashable, V: Equatable> {
    var prev: Node<K, V>?
    var next: Node<K, V>?
    var key: K
    var value: V
    
    init(_ key: K, _ value: V) {
        self.key = key
        self.value = value
    }
}

class LRUCache<K: Hashable, V: Equatable>: LRUCaching {
    typealias K = K
    typealias V = V
    
    var capacity: Int
    var head: Node<K, V>?
    var tail: Node<K, V>?
    var cache: [K: Node<K, V>] = [:]
    
    init(_ capacity: Int) {
        self.capacity = capacity
    }
    
    func put(_ key: K, _ value: V) {
        /// if node already exists in cache, update its value, move it to front
        if let node = cache[key] {
            node.value = value
            remove(node)
            addToFront(node)
        } else {
            let node = Node(key, value)
            /// if cache is full, remove the last item
            if cache.count >= capacity,
               let tail = tail {
                cache[tail.key] = nil
                remove(tail)
            }
            /// add node to front and update cache
            addToFront(node)
            cache[key] = node
        }
    }
    
    func get(_ key: K) -> V? {
        /// if value does not exist, return `nil`
        guard let node = cache[key] else { return nil }
        /// if node is head just return value - ideal situation
        if node.value == head?.value { return node.value }
        /// otherwise remove node from current position
        remove(node)
        /// and add it to the front of the cache for faster next access
        addToFront(node)
        /// finally, return the value
        return node.value
    }
    
    private func remove(_ node: Node<K, V>) {
        /// if previous node is defined, set its next node to removal node's next
        if node.prev != nil {
            node.prev?.next = node.next
        } else {
            /// shouldn't be possible with this implementation but hey
            head = node.next
        }
        /// if next node is defined, set its previous as this node's previous
        if node.next != nil {
            node.next?.prev = node.prev
        } else {
            /// otherwise node == tail, therefore set new tail as the previous node
            tail = node.prev
        }
    }
    
    private func addToFront(_ node: Node<K, V>) {
        /// if cache is empty, just set first head to node
        if head == nil {
            return head = node
        }
        /// set head's previous to this new node
        head?.prev = node
        /// this node's next node will now be current head
        node.next = head
        /// this node has no previous as it's at the beginning
        node.prev = nil
        /// set this node as the new head!
        head = node
        
        /// if we only had one node, set
        if tail == nil {
            tail = head
        }
    }
}